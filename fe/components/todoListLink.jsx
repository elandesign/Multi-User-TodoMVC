import Router from 'react-router';
var Link = Router.Link;

export default class TodoListLink extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return <li id={this.props.id} >
      <Link to="list" params={{listId: this.props.id}}>
        {this.props.name}
      </Link>
    </li>;
  }
}
