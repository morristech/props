import React from 'react';

class Receivers extends React.Component {
  render() {
    const list = this.props.receivers.map((user) => {
      return (
        <a className="props-receiver-avatar" href={`#users/${user.id}`}>
          <img src={user.avatar_url} title={user.name}/>
        </a>
      );
    });
    return <div>{list}</div>;
  }
}

Receivers.propTypes = {
  receivers: React.PropTypes.array.isRequired,
};

export default Receivers;
