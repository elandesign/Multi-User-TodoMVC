import todoActions from '../actions/todoActions.es6';

export default class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
  }

  deleteTodo() {
    todoActions.deleteTodo(this.props.listId, this.props.todoId);
  }

  render() {
    return <li className="todo" id={this.props.id}>
      <input type="checkbox" />
      {this.props.name}
      <i className="fa fa-trash" onClick={this.deleteTodo.bind(this)}></i>
    </li>;
  }
}
