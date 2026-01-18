# TODO API

REST API for task management (todos) built with Express.js and MongoDB.

## Technologies

- **Node.js** - JavaScript runtime
- **Express 5** - Web framework
- **MongoDB** - NoSQL database
- **Mongoose** - MongoDB ODM
- **Helmet** - HTTP security
- **CORS** - Cross-Origin Resource Sharing
- **Morgan** - HTTP request logger

## Project Structure

```tree
src/
├── index.js              # Server entry point
├── config/
│   └── database.js       # MongoDB configuration
├── models/
│   └── Todo.js           # Mongoose model
├── routes/
│   └── todos.js          # Route definitions
├── controllers/
│   └── todoController.js # Endpoint logic
├── services/
│   └── todoService.js    # Data layer
└── middleware/
    └── validateTodo.js   # Data validation
```

## Configuration

### Environment Variables

Create a `.env` file in the project root:

```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/todo_api
NODE_ENV=development
```

### Prerequisites

- Node.js >= 24
- pnpm >= 10
- MongoDB >= 7

## Installation

```bash
# Install dependencies
pnpm install

# Run in development mode (with hot reload)
pnpm dev

# Run in production
pnpm start
```

## API Endpoints

### Health Check

| Method | Route     | Description   |
| ------ | --------- | ------------- |
| `GET`  | `/health` | Server status |

### Todos

| Method   | Route            | Description       |
| -------- | ---------------- | ----------------- |
| `GET`    | `/api/todos`     | Get all todos     |
| `GET`    | `/api/todos/:id` | Get a todo by ID  |
| `POST`   | `/api/todos`     | Create a new todo |
| `PUT`    | `/api/todos/:id` | Update a todo     |
| `DELETE` | `/api/todos/:id` | Delete a todo     |

### Query Parameters

| Parameter   | Type      | Description                   |
| ----------- | --------- | ----------------------------- |
| `completed` | `boolean` | Filter by status (true/false) |
| `search`    | `string`  | Search by title               |

**Examples:**

```text
GET /api/todos?completed=true
GET /api/todos?search=shopping
GET /api/todos?completed=false&search=work
```

## Todo Model

```json
{
  "id": "507f1f77bcf86cd799439011",
  "title": "My task",
  "description": "Optional description",
  "completed": false,
  "priority": "low | medium | high",
  "createdAt": "2026-01-17T10:30:00.000Z",
  "updatedAt": "2026-01-17T10:30:00.000Z"
}
```

### Validations

- `title`: Required, max 200 characters
- `priority`: Must be `low`, `medium`, or `high` (default: `medium`)
- `completed`: Boolean (default: `false`)

## Usage Examples

### Create a todo

```bash
curl -X POST http://localhost:3000/api/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Buy milk", "priority": "high"}'
```

### Get all todos

```bash
curl http://localhost:3000/api/todos
```

### Update a todo

```bash
curl -X PUT http://localhost:3000/api/todos/TODO_ID \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'
```

### Delete a todo

```bash
curl -X DELETE http://localhost:3000/api/todos/TODO_ID
```

## Testing with VS Code

The project includes an `api.http` file to test endpoints directly from VS Code using the [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) extension.
