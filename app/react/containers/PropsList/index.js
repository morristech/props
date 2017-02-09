import { connect } from 'react-redux';
import PropsList from '../../components/PropsList';
import { fetchProps } from '../../actions/props';


const mapStateToProps = state => ({
  propsList: state.props,
  users: state.users,
  hasPrevPage: state.propsPagination.hasPreviousPage,
  hasNextPage: state.propsPagination.hasNextPage,
  currentPage: state.propsPagination.currentPage,
});

const mapDispatchToProps = (dispatch, state) => ({
  onPaginationPrev: (prevPage) => {
    dispatch(fetchProps(prevPage));
  },
  onPaginationNext: (nextPage) => {
    dispatch(fetchProps(nextPage));
  },
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(PropsList);
