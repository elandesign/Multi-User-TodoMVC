import App from './components/app.jsx';
import ListIndex from './components/listIndex.jsx';
import TodoList from './components/todoList.jsx';
import Router from 'react-router';

var DefaultRoute = Router.DefaultRoute;
var Link = Router.Link;
var Route = Router.Route;

var routes = (
  <Route name="app" path="/" handler={App}>
    <DefaultRoute handler={ListIndex} />
    <Route name="lists" handler={ListIndex} />
    <Route name="list" path="lists/:listId" handler={TodoList} />
  </Route>
);

Router.run(routes, function(Handler, state) {
  React.render(<Handler params={state.params} />, document.getElementById("container"));
});
