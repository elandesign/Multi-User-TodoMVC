import TodoListLink from './todoListLink.jsx';

export default class ListIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {"lists": []};
  }

  componentDidMount() {
    fetch("/lists").then(response => {
      return response.json();
    }).catch(ex => {
      console.error('Failed to fetch data', ex);
    }).then(data => {
      this.setState({lists: data});
    });
  }
  changeList(listID, listName) {
    this.props.setList(listID, listName);
   }

  render() {
    var lists = this.state.lists.map(item => {
      return (<TodoListLink id={item.id} name={item.name} key={item.id} />);
    });
    return <div id="lists">
      <ul>
        {lists}
      </ul>
    </div>;
  }
}
