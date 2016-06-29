import React, { PropTypes } from 'react';
import { connect } from 'react-redux';
import { fetchUser, fetchUserProps, fetchUserGivenProps } from '../../actions/index.js';
import PropsStats from './props-stats';
import PropsComponent from './props-component';

class PropsContainer extends React.Component {
  static get propTypes() {
    const { string, object, shape, number, bool, func } = PropTypes;

    return {
      dispatch: PropTypes.func.isRequired,
      params: PropTypes.shape({
        userId: PropTypes.string.isRequired,
      }),
      userName: string,
      givenProps: object,
      receivedProps: object,
      archived: bool,
      meta: shape({
        givenCount: number,
        receivedCount: number,
      }),
      onChangePageReceived: func.isRequired,
      onChangePageGiven: func.isRequired,
      received_props_request: object,
      given_props_request: object,
    };
  }

  constructor(props) {
    super(props);
    this.onClickReceivedPage = this.onClickReceivedPage.bind(this);
    this.onClickGivenPage = this.onClickGivenPage.bind(this);
  }

  componentDidMount() {
    const { dispatch } = this.props;
    const { userId } = this.props.params;
    dispatch(fetchUser(userId));
    dispatch(fetchUserProps(userId));
    dispatch(fetchUserGivenProps(userId));
  }

  onClickReceivedPage({ selected }) {
    const { userId } = this.props.params;
    this.props.onChangePageReceived(userId, selected + 1);
  }

  onClickGivenPage({ selected }) {
    const { userId } = this.props.params;
    this.props.onChangePageGiven(userId, selected + 1);
  }

  render() {
    if (!this.props.userName) {
      return (<div />);
    } else if (this.props.received_props_request || this.props.given_props_request) {
      return (<div className="loading" />);
    }

    const {
      userName, archived, meta, receivedProps, givenProps,
    } = this.props;
    return (
      <div>
        <PropsStats
          userName={userName}
          propsReceivedCount={meta.receivedCount}
          propsGivenCount={meta.givenCount}
          archived={archived}
        />

        <PropsComponent
          title={'Recieved Props'}
          props={receivedProps.props}
          totalPages={receivedProps.meta.total_pages}
          currentPage={receivedProps.meta.current_page}
          onClickPage={this.onClickReceivedPage}
        />

        <PropsComponent
          title={'Given Props'}
          props={givenProps.props}
          totalPages={givenProps.meta.total_pages}
          currentPage={givenProps.meta.current_page}
          onClickPage={this.onClickGivenPage}
        />
      </div>
    );
  }
}

const mapStateToProps = (state) => {
  return {
    receivedProps: state.props.user_received_props,
    givenProps: state.props.user_given_props,
    received_props_request: state.props.received_props_request,
    given_props_request: state.props.given_props_request,
    userName: state.user.name,
    archived: state.user.archived,
    meta: {
      receivedCount: state.user.props_count.received,
      givenCount: state.user.props_count.given,
    },
  };
};

const mapDispatchToProps = (dispatch) => ({
  onChangePageReceived: (userId, selectedPage) => {
    dispatch(fetchUserProps(userId, selectedPage));
  },
  onChangePageGiven: (userId, selectedPage) => {
    dispatch(fetchUserGivenProps(userId, selectedPage));
  },
  dispatch,
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PropsContainer);
