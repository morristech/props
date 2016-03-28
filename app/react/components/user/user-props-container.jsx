import React, { PropTypes } from 'react';
import { connect } from 'react-redux';

import { fetchUser, fetchUserProps, fetchUserGivenProps } from '../../actions/index.js';
import UserProps from './user-props';

class UserPropsContainer extends React.Component {
  static get propTypes() {
    return {
      dispatch: PropTypes.func.isRequired,
      params: PropTypes.shape({
        userId: PropTypes.string.isRequired,
      }),
    };
  }

  componentDidMount() {
    const { dispatch } = this.props;
    const { userId } = this.props.params;
    dispatch(fetchUser(userId));
    dispatch(fetchUserProps(userId));
    dispatch(fetchUserGivenProps(userId));
  }

  render() {
    return (
      <UserProps {...this.props} />
    );
  }
}

const mapStateToProps = (state) => {
  return {
    receivedProps: state.props.user_received_props,
    givenProps: state.props.user_given_props,
    userName: state.user.name,
  };
};

export default connect(
  mapStateToProps
)(UserPropsContainer);
