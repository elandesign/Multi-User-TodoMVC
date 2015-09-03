import todoActions from '../actions/todoActions.es6';

export default class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {text: ""};
  }

  onAdd() {
    todoActions.addTodo(this.props.listId, this.state.text);
  }

  onChange(event) {
    this.setState({text: event.target.value});
  }

  render() {
    return <li>
      <input type="text" value={this.state.text} onChange={this.onChange.bind(this)} />
      <input type="button" value="Add" onClick={this.onAdd.bind(this)} />
    </li>;
  }
}
