import alt from '../alt.es6';

class TodoActions {
  addTodo(listId, name) {
    return (dispatch) => {
      fetch('/lists/' + listId + '/items', {
        method: 'post',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ item: { name: name } })
      }).then(response => {
        return response.json();
      }).then(data => {
        dispatch([data.id, data.name]);
      });
    }
  }

  deleteTodo(listId, itemId) {
    return (dispatch) => {
      fetch('/lists/' + listId + '/items/' + itemId, {method: 'delete'}).then(response => {
        dispatch(itemId);
      });
    }
  }

  listLoad(listId) {
    return (dispatch) => {
      fetch('/lists/' + listId + '/items').then(response => {
        return response.json();
      }).then(todos => {
        fetch('/lists/' + listId).then(response => {
          return response.json();
        }).then(data => {
          dispatch([data.id, data.name, todos]);
        });
      });
    }
  }
}

const todoActions = alt.createActions(TodoActions);
export default todoActions;
