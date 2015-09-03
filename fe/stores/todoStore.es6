import todoActions from '../actions/todoActions.es6';
import alt from '../alt.es6';
import _ from 'lodash';

class TodoStore {
  constructor() {
    this.bindAction(todoActions.addTodo, this.onAddTodo);
    this.bindAction(todoActions.deleteTodo, this.onDeleteTodo);
    this.bindAction(todoActions.listLoad, this.onListLoad);

    this.state = {
      todos: [],
      listId: undefined,
      name: "List"
    }
  }

  onListLoad(obj) {
    const [ listId, listName, todos ] = obj;
    this.setState({
      listId: listId,
      name: listName,
      todos: todos
    });
  }

  onAddTodo(obj) {
    const [ todoId, name ] = obj;
    var todos = this.state.todos;
    todos.push({id: todoId, name: name});
    this.setState({todos: todos});
  }

  onDeleteTodo(todoId) {
    var todos = _.reject(this.state.todos, {id: todoId});
    this.setState({todos: todos});
  }
}

const todoStore = alt.createStore(TodoStore);
export default todoStore;
