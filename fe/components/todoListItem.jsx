import todoActions from '../actions/todoActions.es6';

export default class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
  }

  deleteTodo() {
    todoActions.deleteTodo(this.props.listId, this.props.todoId);
  }

  render() {
    return <li className="todo" id={this.props.todoId}>
      <label htmlFor={"chk-" + this.props.todoId}>{this.props.name}</label>
      <input type="checkbox" id={"chk-" + this.props.todoId} />
      <i className="fa fa-trash" onClick={this.deleteTodo.bind(this)}></i>
    </li>
  }
}
