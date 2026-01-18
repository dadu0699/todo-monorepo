import { CdkDragDrop, CdkDragPlaceholder, DragDropModule } from '@angular/cdk/drag-drop';
import { Component, computed, inject, OnInit, signal, ViewChild } from '@angular/core';
import { CreateTodoDto, Todo, UpdateTodoDto } from '../../models/todo.model';
import { TodoService } from '../../services/todo.service';
import { AddTodoModalComponent } from '../add-todo-modal/add-todo-modal.component';
import { EditTodoModalComponent } from '../edit-todo-modal/edit-todo-modal.component';
import { TaskCardComponent } from '../task-card/task-card.component';

@Component({
  selector: 'app-todo-board',
  standalone: true,
  imports: [
    TaskCardComponent,
    AddTodoModalComponent,
    EditTodoModalComponent,
    DragDropModule,
    CdkDragPlaceholder,
  ],
  templateUrl: './todo-board.component.html',
})
export class TodoBoardComponent implements OnInit {
  @ViewChild(AddTodoModalComponent) addModal!: AddTodoModalComponent;
  @ViewChild(EditTodoModalComponent) editModal!: EditTodoModalComponent;

  private readonly todoService = inject(TodoService);

  todos = signal<Todo[]>([]);
  isLoading = signal(true);
  error = signal<string | null>(null);
  isModalOpen = signal(false);
  isEditModalOpen = signal(false);
  editingTodo = signal<Todo | null>(null);

  pendingTodos = computed(() =>
    this.todos()
      .filter((t) => !t.completed)
      .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()),
  );

  completedTodos = computed(() =>
    this.todos()
      .filter((t) => t.completed)
      .sort((a, b) => new Date(b.updatedAt).getTime() - new Date(a.updatedAt).getTime()),
  );

  ngOnInit(): void {
    this.loadTodos();
  }

  loadTodos(): void {
    this.isLoading.set(true);
    this.error.set(null);

    this.todoService.getAll().subscribe({
      next: (todos) => {
        this.todos.set(todos);
        this.isLoading.set(false);
      },
      error: (err) => {
        console.error('Failed to load todos:', err);
        this.error.set('Failed to load tasks. Please try again.');
        this.isLoading.set(false);
      },
    });
  }

  openModal(): void {
    this.isModalOpen.set(true);
  }

  closeModal(): void {
    this.isModalOpen.set(false);
  }

  createTodo(dto: CreateTodoDto): void {
    this.todoService.create(dto).subscribe({
      next: (newTodo) => {
        this.todos.update((todos) => [newTodo, ...todos]);
        this.addModal.onSuccess();
      },
      error: (err) => {
        console.error('Failed to create todo:', err);
        this.addModal.onError('Failed to create task. Please try again.');
      },
    });
  }

  openEditModal(todo: Todo): void {
    this.editingTodo.set(todo);
    this.isEditModalOpen.set(true);
  }

  closeEditModal(): void {
    this.isEditModalOpen.set(false);
    this.editingTodo.set(null);
  }

  updateTodo(event: { id: string; dto: UpdateTodoDto }): void {
    this.todoService.update(event.id, event.dto).subscribe({
      next: (updated) => {
        this.todos.update((todos) => todos.map((t) => (t.id === updated.id ? updated : t)));
        this.editModal.onSuccess();
      },
      error: (err) => {
        console.error('Failed to update todo:', err);
        this.editModal.onError('Failed to update task. Please try again.');
      },
    });
  }

  drop(event: CdkDragDrop<Todo[]>): void {
    if (event.previousContainer === event.container) {
      return;
    }

    const todo = event.item.data as Todo;
    const newCompleted = !todo.completed;

    // Optimistic update
    this.todos.update((todos) =>
      todos.map((t) => (t.id === todo.id ? { ...t, completed: newCompleted } : t)),
    );

    // API call with full payload
    this.todoService
      .update(todo.id, {
        title: todo.title,
        description: todo.description,
        completed: newCompleted,
        priority: todo.priority,
      })
      .subscribe({
        next: (updated) => {
          this.todos.update((todos) => todos.map((t) => (t.id === updated.id ? updated : t)));
        },
        error: (err) => {
          console.error('Failed to update todo:', err);
          // Revert on error
          this.todos.update((todos) =>
            todos.map((t) => (t.id === todo.id ? { ...t, completed: todo.completed } : t)),
          );
        },
      });
  }

  deleteTodo(todo: Todo): void {
    this.todoService.delete(todo.id).subscribe({
      next: () => {
        this.todos.update((todos) => todos.filter((t) => t.id !== todo.id));
      },
      error: (err) => {
        console.error('Failed to delete todo:', err);
      },
    });
  }
}
