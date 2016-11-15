import React, { PropTypes } from 'react';

export default class User extends React.Component {
  static get propTypes() {
    return {
      userObject: PropTypes.shape({
        id: PropTypes.number.isRequired,
        name: PropTypes.string.isRequired,
        avatar_url: PropTypes.string.isRequired,
      }),
    };
  }

  render() {
    const {
      userObject,
    } = this.props;

    let user = null;


    if (userObject) {
      const reveiverUrl = `#users/${userObject.id}`;
      user =
      (
        <a className="props-receiver-avatar" href={reveiverUrl}>
          <img src={userObject.avatar_url} title={userObject.name} alt="avatar" />
        </a>
      );
    }

    return (
      <div>{ user }</div>
    );
  }
}
