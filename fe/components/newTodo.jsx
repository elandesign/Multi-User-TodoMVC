import todoActions from '../actions/todoActions.es6';

export default class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {text: ""};
  }

  onAdd() {
    todoActions.addTodo(this.props.listId, this.state.text);
    this.setState({text: ""});
  }

  onChange(event) {
    this.setState({text: event.target.value});
  }

  _onKeyDown(event) {
    if (event.keyCode === 13) { // ENTER
      this.onAdd();
    }
  }

  render() {
    return <li className="todo">
      <input type="text" className="addTodo" tabIndex="1" value={this.state.text} onChange={this.onChange.bind(this)} onKeyDown={this._onKeyDown.bind(this)} />
      <input type="button" value="Add" onClick={this.onAdd.bind(this)} />
    </li>;
  }
}
