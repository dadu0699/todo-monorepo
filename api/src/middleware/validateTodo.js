const VALID_PRIORITIES = ['low', 'medium', 'high'];

export const validateTodo = (req, res, next) => {
  const { title, priority } = req.body;

  if (!title || typeof title !== 'string')
    return res.status(400).json({ error: 'Title is required and must be a string' });

  if (title.trim().length === 0) return res.status(400).json({ error: 'Title cannot be empty' });

  if (title.length > 200)
    return res.status(400).json({ error: 'Title must be less than 200 characters' });

  if (priority !== undefined && !VALID_PRIORITIES.includes(priority)) {
    return res.status(400).json({
      error: `Priority must be one of: ${VALID_PRIORITIES.join(', ')}`,
    });
  }

  req.body.title = title.trim();
  next();
};
