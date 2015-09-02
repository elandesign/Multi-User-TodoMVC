import React from 'react/addons';
import TodoListLink from './todoListLink.jsx';

export default class ListIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {"lists": []};
  }

  componentDidMount() {
    fetch("/lists").then(response => {
      return response.json();
    }).then(data => {
      this.setState({lists: data});
    }).catch(ex => {
      console.error('Failed to fetch data', ex);
    });
  }
  changeList(listID, listName) {
    this.props.setList(listID, listName);
   }

  render() {
    var lists = this.state.lists.map(item => {
      return (<TodoListLink id={item.id} name={item.name} key={item.id} click={this.changeList.bind(this, item.id, item.name)} />);
    });
    return <div id="lists">
      <ul>
        {lists}
      </ul>
    </div>;
  }
}
