import Router from 'react-router';
import TodoListItem from './todoListItem.jsx';
var Link = Router.Link;

export default class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {"items": []};
  }

  componentDidMount() {
    var listId = this.context.router.getCurrentParams().listId;
    fetch("/lists/" + listId + "/items").then(response => {
      return response.json();
    }).catch(ex => {
      console.error('Failed to fetch data', ex);
    }).then(data => {
      this.setState({items: data});
    });
  }

  render() {
    var items = this.state.items.map(item => {
      return (<TodoListItem id={item.id} name={item.name} key={item.id} />);
    });
    return <div>
      <h2>{this.props.name}</h2>
      <ul id="items">
        {items}
      </ul>
      <Link to="lists">Back</Link>
    </div>;
  }
}

TodoList.contextTypes = {
  router: React.PropTypes.func.isRequired
};
