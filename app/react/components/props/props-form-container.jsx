import { createProp, changeThanksTextChange, fetchUsers, selectUsers } from '../../actions/index';
import { connect } from 'react-redux';
import PropsForm from './props-form';

const mapStateToProps = (state) => ({
  avatars: state.users
    .filter((user) =>
      state.props.selected_users.includes(user.id.toString())
    ).map((user) =>
      user.avatar_url
    ),
  selected_users: state.users
    .filter((user) =>
      state.props.selected_users.includes(user.id.toString())
    ).map((user) => {
      return { value: user.id, label: user.name, avatarUrl: user.avatar_url };
    }),
  users: state.users.map((user) => {
    return { value: user.id, label: user.name, avatarUrl: user.avatar_url };
  }),
  selected_users_ids: state.props.selected_users,
  prop_creation_errors: state.props.prop_creation_errors,
  prop_creation_request: state.props.prop_creation_request,
  thanksText: state.props.thanksText,
});

const mapDispatchToProps = (dispatch) => ({
  onPropSubmit: (formData) => {
    dispatch(createProp(formData));
  },
  onThanksTextChange: (thanksText) => {
    dispatch(changeThanksTextChange(thanksText));
  },
  onFormLoad: () => {
    dispatch(fetchUsers());
  },
  onSelectChange: (id) => {
    dispatch(selectUsers(id));
  },
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PropsForm);
