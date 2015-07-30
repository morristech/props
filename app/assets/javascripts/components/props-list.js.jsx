import React from 'react';
import PropComponent from './prop';
import PaginationComponent from './pagination';

class PropsList extends React.Component {
  constructor(props) {
    super(props);

    this.onChange = this.onChange.bind(this);
    this.onNextPage = this.onNextPage.bind(this);
    this.onPrevPage = this.onPrevPage.bind(this);

    const list = this.props.props;
    list.bind('change', this.onChange);
    list.bind('add', this.onChange);
    this.state = {props: list};
  }

  onChange() {
    this.setState(this.state);
  }

  onNextPage(e) {
    e.preventDefault();
    const _this = this;
    this.state.props.getNextPage({
      success: _this.onChange,
    });
  }

  onPrevPage(e) {
    e.preventDefault();
    const _this = this;
    this.state.props.getPreviousPage({
      success: _this.onChange,
    });
  }

  render() {
    const list = this.state.props.map((item) => {
      return <PropComponent prop={item} key={item.id}/>;
    });
    const emptyView = 'no props here';

    return (
      <div>
        <div>{list.length > 0 ? list : emptyView}</div>
        <PaginationComponent
          currentPage={this.state.props.state.currentPage}
          onNextPageClick={this.onNextPage}
          onPrevPageClick={this.onPrevPage}
          hasPreviousPage={this.state.props.hasPreviousPage()}
          hasNextPage={this.state.props.hasNextPage()}/>
      </div>
    );
  }
}

PropsList.propTypes = {
  props: React.PropTypes.object.isRequired,
};

export default PropsList;
