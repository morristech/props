import React from 'react';

class SelectedUsers extends React.Component {
  render() {
    const list = this.props.avatars.map( (avatarUrl, index) => {
      return <img className="praised-person-avatar" src={avatarUrl} key={index}/>;
    });
    return <div>{list}</div>;
  }
}

SelectedUsers.propTypes = {
  avatars: React.PropTypes.array.isRequired,
};

export default SelectedUsers;
