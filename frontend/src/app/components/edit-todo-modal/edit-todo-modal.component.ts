import {
  Component,
  EventEmitter,
  Input,
  OnChanges,
  Output,
  signal,
  SimpleChanges,
} from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Todo, UpdateTodoDto } from '../../models/todo.model';

@Component({
  selector: 'app-edit-todo-modal',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './edit-todo-modal.component.html',
})
export class EditTodoModalComponent implements OnChanges {
  @Input() isOpen = false;
  @Input() todo: Todo | null = null;
  @Output() closeModal = new EventEmitter<void>();
  @Output() todoUpdated = new EventEmitter<{ id: string; dto: UpdateTodoDto }>();

  title = '';
  description = '';
  priority: 'low' | 'medium' | 'high' = 'medium';

  isSubmitting = signal(false);
  error = signal<string | null>(null);

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['todo'] && this.todo) {
      this.title = this.todo.title;
      this.description = this.todo.description || '';
      this.priority = this.todo.priority;
    }
  }

  close(): void {
    this.resetForm();
    this.closeModal.emit();
  }

  onSubmit(): void {
    if (!this.title.trim() || this.isSubmitting() || !this.todo) return;

    this.isSubmitting.set(true);
    this.error.set(null);

    const dto: UpdateTodoDto = {
      title: this.title.trim(),
      description: this.description.trim() || undefined,
      completed: this.todo.completed,
      priority: this.priority,
    };

    this.todoUpdated.emit({ id: this.todo.id, dto });
  }

  onSuccess(): void {
    this.isSubmitting.set(false);
    this.close();
  }

  onError(message: string): void {
    this.isSubmitting.set(false);
    this.error.set(message);
  }

  private resetForm(): void {
    this.title = '';
    this.description = '';
    this.priority = 'medium';
    this.error.set(null);
    this.isSubmitting.set(false);
  }
}
