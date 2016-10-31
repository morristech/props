import React, { PropTypes } from 'react';
import { connect } from 'react-redux';

const App = ({ children }) =>
  <div>
    {children}
  </div>;

function mapStateToProps(state, ownProps) {
  return { currentPath: ownProps.location.pathname };
}

App.propTypes = {
  children: PropTypes.node,
};

export default connect(mapStateToProps)(App);
