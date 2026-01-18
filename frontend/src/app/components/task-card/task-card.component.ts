import { DatePipe, NgClass } from '@angular/common';
import { Component, EventEmitter, Input, Output, signal } from '@angular/core';
import { Todo } from '../../models/todo.model';

@Component({
  selector: 'app-task-card',
  standalone: true,
  imports: [DatePipe, NgClass],
  templateUrl: './task-card.component.html',
})
export class TaskCardComponent {
  @Input({ required: true }) todo!: Todo;
  @Output() delete = new EventEmitter<Todo>();
  @Output() edit = new EventEmitter<Todo>();

  isDeleting = signal(false);

  get priorityClasses(): Record<string, boolean> {
    return {
      'bg-neutral-700 text-neutral-300': this.todo.priority === 'low',
      'bg-blue-900/50 text-blue-400': this.todo.priority === 'medium',
      'bg-red-900/50 text-red-400': this.todo.priority === 'high',
    };
  }

  onEdit(): void {
    this.edit.emit(this.todo);
  }

  onDelete(): void {
    if (this.isDeleting()) return;
    this.isDeleting.set(true);
    this.delete.emit(this.todo);
  }

  resetDeleting(): void {
    this.isDeleting.set(false);
  }
}
