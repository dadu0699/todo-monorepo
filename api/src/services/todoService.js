import Todo from '../models/Todo.js';

export const getAll = async (filters = {}) => {
  const query = {};

  if (filters.completed !== undefined) query.completed = filters.completed;
  if (filters.search) query.title = { $regex: filters.search, $options: 'i' };

  return Todo.find(query).sort({ createdAt: -1 });
};

export const getById = async (id) => {
  return Todo.findById(id);
};

export const create = async ({ title, description = '', priority = 'medium' }) => {
  const todo = new Todo({ title, description, priority });
  return todo.save();
};

export const update = async (id, updates) => {
  const cleanUpdates = Object.fromEntries(
    Object.entries(updates).filter(([_, v]) => v !== undefined),
  );

  return Todo.findByIdAndUpdate(id, cleanUpdates, {
    new: true,
    runValidators: true,
  });
};

export const remove = async (id) => {
  const result = await Todo.findByIdAndDelete(id);
  return result !== null;
};

export const clear = async () => {
  await Todo.deleteMany({});
};
