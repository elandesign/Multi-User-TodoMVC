class ListIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = {"lists": []};
  }

  componentDidMount() {
    $.ajax({
      url: "/lists",
      dataType: "json",
      cache: false,
      success: data => { this.setState({lists: data}); },
      error: (xhr, status, err) => { console.error(status, err.toString()); }
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
