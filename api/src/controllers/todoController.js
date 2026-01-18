import * as todoService from '../services/todoService.js';

export const getAllTodos = async (req, res) => {
  try {
    const { completed, search } = req.query;
    const filters = {};

    if (completed !== undefined) filters.completed = completed === 'true';
    if (search) filters.search = search;

    const todos = await todoService.getAll(filters);
    res.json(todos);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const getTodoById = async (req, res) => {
  try {
    const todo = await todoService.getById(req.params.id);
    if (!todo) return res.status(404).json({ error: 'Todo not found' });
    res.json(todo);
  } catch (error) {
    if (error.name === 'CastError')
      return res.status(400).json({ error: 'Invalid todo ID format' });
    res.status(500).json({ error: error.message });
  }
};

export const createTodo = async (req, res) => {
  try {
    const { title, description, priority } = req.body;
    const todo = await todoService.create({ title, description, priority });
    res.status(201).json(todo);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

export const updateTodo = async (req, res) => {
  try {
    const { title, description, completed, priority } = req.body;
    const todo = await todoService.update(req.params.id, {
      title,
      description,
      completed,
      priority,
    });
    if (!todo) return res.status(404).json({ error: 'Todo not found' });
    res.json(todo);
  } catch (error) {
    if (error.name === 'CastError')
      return res.status(400).json({ error: 'Invalid todo ID format' });
    res.status(500).json({ error: error.message });
  }
};

export const deleteTodo = async (req, res) => {
  try {
    const deleted = await todoService.remove(req.params.id);
    if (!deleted) return res.status(404).json({ error: 'Todo not found' });
    res.status(204).send();
  } catch (error) {
    if (error.name === 'CastError')
      return res.status(400).json({ error: 'Invalid todo ID format' });
    res.status(500).json({ error: error.message });
  }
};
