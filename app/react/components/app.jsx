import React, { PropTypes } from 'react';

export default class App extends React.Component {
  static get PropTypes() {
    return {
      children: PropTypes.element,
    };
  }

  render() {
    const { children: subPage } = this.props;

    return (
      <div>
        {subPage}
      </div>
    );
  }
}
