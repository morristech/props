import React from 'react';
import PaginatedProps from './paginated-props';

export default class PropsComponent extends React.Component {

  static get propTypes() {
    return {
      title: React.PropTypes.string,
    };
  }

  render() {
    return (
      <div>
        <h2>{this.props.title}</h2>
        <PaginatedProps {...this.props} />
      </div>
    );
  }
}
