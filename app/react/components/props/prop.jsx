import React from 'react';
import moment from 'moment';

import VoteComponent from './vote';
import UserComponent from './../user';

export default class Prop extends React.Component {
  static get propTypes() {
    return {
      prop: React.PropTypes.object.isRequired,
    };
  }

  constructor(props) {
    super(props);
    this.onUpVote = this.onUpVote.bind(this);
  }

  onUpVote() {
    this.props.prop.upvote();
  }

  render() {
    const createdAt = moment(this.props.prop.get('created_at')).fromNow();
    const receivers = this.props.prop.get('users').map((receiver) => {
      return <UserComponent user={receiver} key={receiver.id}/>;
    });

    return (
      <li className = "row list-group-item props-list-item">
        <div className="col-xs-12 prop-users">
          <UserComponent user={this.props.prop.get('propser')}/>
          <i className="glyphicon glyphicon-chevron-right prop-to"></i>
          {receivers}
        </div>
        <div className="col-xs-12 prop-content">
          <p className="lead prop-body">
            {this.props.prop.get('body')}
          </p>
          <div className="row">
            <div className="col-xs-12 prop-footer">
              <div className="prop-create-at pull-left">
                {createdAt}
              </div>
              <VoteComponent
                upvotesCount={this.props.prop.get('upvotes_count')}
                isUpvotePossible={this.props.prop.get('is_upvote_possible')}
                onUpvote={this.onUpVote}
              />
            </div>
          </div>
        </div>
      </li>
  );
  }
}
