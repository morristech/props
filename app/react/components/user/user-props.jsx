import React, { PropTypes } from 'react';
import UserPropsStats from './user-props-stats';
import PropComponent from '../props/prop';
const isEmpty = require('lodash/isEmpty');

export default class UserProps extends React.Component {
  static get propTypes() {
    const { string, object, shape, number, bool } = PropTypes;
    return {
      userName: string,
      givenProps: object,
      receivedProps: object,
      archived: bool,
      meta: shape({
        givenCount: number,
        receivedCount: number,
      }),
    };
  }

  renderProps(props) {
    return props.map((prop) => {
      return (
        <PropComponent
          prop={prop}
          key={prop.id}
        />
      );
    });
  }

  render() {
    const { userName, givenProps, receivedProps, meta, archived } = this.props;

    if (!userName || isEmpty(givenProps) || isEmpty(receivedProps)) {
      return (
        <div className="loading"/>
      );
    }

    return (
      <div>
        <UserPropsStats
          userName={userName}
          propsReceivedCount={meta.receivedCount}
          propsGivenCount={meta.givenCount}
          archived={archived}
        />

        <h2>Received props</h2>
        <ul className="list-unstyled">
          <div className="col-xs-12">
            {this.renderProps(receivedProps.props)}
          </div>
        </ul>


        <h2>Given props</h2>
        <ul className="list-unstyled">
          <div className="col-xs-12">
            {this.renderProps(givenProps.props)}
          </div>
        </ul>

      </div>
    );
  }
}
