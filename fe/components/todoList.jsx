import TodoListItem from './todoListItem.jsx';

export default class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {"items": []};
  }

  componentDidMount() {
    fetch("/lists/" + this.props.id + "/items").then(response => {
      return response.json();
    }).then(data => {
      this.setState({items: data});
    }).catch(ex => {
      console.error('Failed to fetch data', ex);
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
      <a href="#" onClick={this.props.reset}>Back</a>
    </div>;
  }
}
