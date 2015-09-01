class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {"list": undefined};
  }

  setList(listID, listName) {
    this.setState({"list": {id: listID, name: listName}});
  }

  reset() {
    this.setState({"list": undefined});
  }

  render() {
    if (this.state.list === undefined) {
      return <ListIndex setList={this.setList.bind(this)} />;
    } else {
      return <TodoList id={this.state.list.id} name={this.state.list.name} reset={this.reset.bind(this)} />;
    }
  }
}
