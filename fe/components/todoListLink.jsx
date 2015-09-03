export default class TodoListLink extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return <li id={this.props.id} >
      <a href="#" onClick={this.props.click}>
        {this.props.name}
      </a>
    </li>;
  }
}
