import { HttpClient } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { CreateTodoDto, Todo, UpdateTodoDto } from '../models/todo.model';

@Injectable({
  providedIn: 'root',
})
export class TodoService {
  private readonly http = inject(HttpClient);
  private readonly baseUrl = 'http://localhost:3000/api/todos';

  getAll(): Observable<Todo[]> {
    return this.http.get<Todo[]>(this.baseUrl);
  }

  create(dto: CreateTodoDto): Observable<Todo> {
    return this.http.post<Todo>(this.baseUrl, dto);
  }

  update(id: string, dto: UpdateTodoDto): Observable<Todo> {
    return this.http.put<Todo>(`${this.baseUrl}/${id}`, dto);
  }

  delete(id: string): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`);
  }
}
