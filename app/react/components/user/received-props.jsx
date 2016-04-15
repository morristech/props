import React from 'react';
import PaginatedProps from './paginated-props';

export default class ReceivedProps extends React.Component {
  render() {
    return (
      <div>
        <h2>Received props</h2>
        <PaginatedProps
          {...this.props}
        />
      </div>
    );
  }
}
