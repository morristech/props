import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import Select from 'react-select';
import UserOptionComponent from './prop-user-option';
import SelectedUsersComponent from './selected-users';
import { createProp, changeThanksTextChange, fetchUsers, selectUsers } from '../../actions/index';
import classNames from 'classnames';

class PropsForm extends React.Component {

  static get propTypes() {
    return {
      avatars: PropTypes.array,
      selected_users: PropTypes.array,
      users: PropTypes.array,
      selected_users_ids: PropTypes.array,
      prop_creation_errors: PropTypes.object,
      prop_creation_request: PropTypes.bool,
      thanksText: PropTypes.string,
      onPropSubmit: PropTypes.func,
      onThanksTextChange: PropTypes.func,
      onFormLoad: PropTypes.func,
      onSelectChange: PropTypes.func,
    };
  }

  constructor(props) {
    super(props);
    this.onPropSubmit = this.onPropSubmit.bind(this);
    this.renderBodyError = this.renderBodyError.bind(this);
    this.bodyErrorClass = this.bodyErrorClass.bind(this);
    this.renderSelectError = this.renderSelectError.bind(this);
    this.selectErrorClass = this.selectErrorClass.bind(this);
    this.onThanksTextChange = this.onThanksTextChange.bind(this);
  }

  componentDidMount() {
    this.props.onFormLoad();
  }

  onPropSubmit(event) {
    event.preventDefault();
    let formData = new FormData();
    formData.append('user_ids', this.props.selected_users_ids);
    formData.append('body', event.target.getElementsByTagName('textarea')[0].value);
    this.props.onPropSubmit(formData)
  }

  onThanksTextChange(event){
    this.props.onThanksTextChange(event.target.value);
  }

  bodyErrorClass() {
    return classNames('form-group',{
      'has-error': this.props.prop_creation_errors.body
    });
  }

  renderBodyError(){
    if(this.props.prop_creation_errors.body) {
      return (
        <span className="help-block error">
          {this.props.prop_creation_errors.body[0]}
        </span>
      );
    }
  }

  selectErrorClass() {
    return classNames('form-group',{
      'has-error': this.props.prop_creation_errors.user_ids
    });
  }

  renderSelectError(){
    if(this.props.prop_creation_errors.user_ids) {
      return (
        <span className="help-block error">
          {this.props.prop_creation_errors.user_ids[0]}
        </span>
      );
    }
  }

  render() {
    let {
      prop_creation_request,
      avatars,
      thanksText,
      users
    } = this.props;

    if(prop_creation_request) {
      return (
        <div className="loading" />
      );
    }
    return(
      <div classNameName="header-region row">
        <div className="jumbotron clearfix">
          <div className="form-region">
            <form data-type="new" onSubmit={this.onPropSubmit}>
              <div id="form-content-region">
                <div>
                  <SelectedUsersComponent avatars={avatars} />
                  <div className={ this.selectErrorClass() }>
                    <div className="users-select">
                      <Select
                        options={users}
                        multi={true}
                        optionComponent={UserOptionComponent}
                        name='user_ids'
                        placeholder='Whom do you want to give a prop to?'
                        onChange={this.props.onSelectChange}
                        value={this.props.selected_users}
                      />
                      {this.renderSelectError()}
                    </div>
                  </div>
                  <div className={this.bodyErrorClass()}>
                    <textarea
                      className="form-control"
                      id="prop_body"
                      name="body"
                      rows="2"
                      placeholder="What do you want to thank for?"
                      value={thanksText}
                      onChange={this.onThanksTextChange}>
                    </textarea>
                    { this.renderBodyError() }
                  </div>
                </div>
              </div>
              <footer className="form-footer">
                <ul className="list-inline">
                  <li className="pull-right">
                    <button className="form-button btn btn-primary" data-form-button="primary" type="submit">Prop!</button>
                  </li>
                </ul>
              </footer>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  avatars: state.users
    .filter((user) => {
      return state.props.selected_users.includes(user.id.toString());
    }).map((user) => {
      return user.avatar_url;
    }),
  selected_users: state.users
    .filter((user) => {
      return state.props.selected_users.includes(user.id.toString());
    }).map((user) => {
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

const mapDispatchToProps = (dispatch) => {
  return {
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
    }
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(PropsForm);
