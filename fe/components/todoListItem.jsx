import React from 'react/addons';

export default class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return <li id={this.props.id}>
      <input type="checkbox" />
      {this.props.name}
    </li>;
  }
}
