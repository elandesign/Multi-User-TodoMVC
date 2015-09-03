import Router from 'react-router';
import TodoListItem from './todoListItem.jsx';
import NewTodo from './newTodo.jsx';
import todoStore from '../stores/todoStore.es6';
import todoActions from '../actions/todoActions.es6';
import connectToStores from 'alt/utils/connectToStores';
var Link = Router.Link;

class TodoList extends React.Component {
  constructor(props) {
    super(props);
    todoActions.listLoad(4);
  }

  static getStores() {
    return [todoStore];
  }

  static getPropsFromStores() {
    return todoStore.getState()
  }

  onTodoUpdate(data) {
    console.log(data);
  }

  render() {
    var items = this.props.todos.map(item => {
      return (<TodoListItem listId={this.props.listId} todoId={item.id} name={item.name} key={item.id} />);
    });
    return <div>
      <h2>{this.props.name}</h2>
      <ul id="items">
        {items}
        <NewTodo listId={this.props.listId} />
      </ul>
      <Link to="lists">Back</Link>
    </div>;
  }
}

TodoList.contextTypes = {
  router: React.PropTypes.func.isRequired
};

export default connectToStores(TodoList);
