import React from 'react';

export default class User extends React.Component {
  static get propTypes() {
    return {
      user: React.PropTypes.object.isRequired,
    };
  }

  render() {
    const reveiverUrl = `#users/${this.props.user.id}`;
    return (
      <a className="props-receiver-avatar" href={reveiverUrl}>
        <img src={this.props.user.avatar_url} title={this.props.user.name}/>
      </a>
    );
  }
}
