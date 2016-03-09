import React from 'react';
import moment from 'moment';

import VoteComponent from './vote';
import UserComponent from './../user/thumb-small';

export default class Prop extends React.Component {
  static get propTypes() {
    return {
      prop: React.PropTypes.object.isRequired,
      onUpvote: React.PropTypes.func.isRequired,
    };
  }

  render() {
    const createdAt = moment(this.props.prop.createdAt).fromNow();
    const receivers = this.props.prop.users.map((receiver) => {
      return <UserComponent user={receiver} key={receiver.id}/>;
    });

    return (
      <li className="row list-group-item props.prop-list-item">
        <div className="col-xs-12 prop-users">
          <UserComponent user={this.props.prop.propser}/>
          <i className="glyphicon glyphicon-chevron-right prop-to"></i>
          {receivers}
        </div>
        <div className="col-xs-12 prop-content">
          <p className="lead prop-body">
            {this.props.prop.body}
          </p>
          <div className="row">
            <div className="col-xs-12 prop-footer">
              <div className="prop-create-at pull-left">
                {createdAt}
              </div>
              <VoteComponent
                upvotesCount={this.props.prop.upvotesCount}
                isUpvotePossible={this.props.prop.isUpvotePossible}
                onUpvote={this.props.onUpvote}
              />
            </div>
          </div>
        </div>
      </li>
  );
  }
}
