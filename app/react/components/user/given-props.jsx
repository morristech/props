import React from 'react';
import PaginatedProps from './paginated-props';

export default class GivenProps extends React.Component {
  render() {
    return (
      <div>
        <h2>Given props</h2>
        <PaginatedProps
          {...this.props}
        />
      </div>
    );
  }
}
