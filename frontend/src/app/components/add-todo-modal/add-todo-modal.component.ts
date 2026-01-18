import { Component, EventEmitter, Input, Output, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CreateTodoDto } from '../../models/todo.model';

@Component({
  selector: 'app-add-todo-modal',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './add-todo-modal.component.html',
})
export class AddTodoModalComponent {
  @Input() isOpen = false;
  @Output() closeModal = new EventEmitter<void>();
  @Output() todoCreated = new EventEmitter<CreateTodoDto>();

  title = '';
  description = '';
  priority: 'low' | 'medium' | 'high' = 'medium';

  isSubmitting = signal(false);
  error = signal<string | null>(null);

  close(): void {
    this.resetForm();
    this.closeModal.emit();
  }

  onSubmit(): void {
    if (!this.title.trim() || this.isSubmitting()) return;

    this.isSubmitting.set(true);
    this.error.set(null);

    const dto: CreateTodoDto = {
      title: this.title.trim(),
      priority: this.priority,
    };

    if (this.description.trim()) {
      dto.description = this.description.trim();
    }

    this.todoCreated.emit(dto);
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
