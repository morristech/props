import React from 'react';
import PropComponent from './prop';
import PaginationComponent from '.././shared/pagination';

export default class PropsList extends React.Component {
  static get propTypes() {
    return {
      props: React.PropTypes.object.isRequired,
    };
  }

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
      const propData = {
        body: item.get('body'),
        createdAt: item.get('created_at'),
        users: item.get('users'),
        propser: item.get('propser'),
        upvotesCount: item.get('upvotes_count'),
        isUpvotePossible: item.get('is_upvote_possible'),
      };
      return (
        <PropComponent
          prop={propData}
          onUpvote={item.upvote.bind(item)}
          key={item.id}
        />
      );
    });
    const emptyView = 'no props here';

    return (
      <div>
        <div className="col-xs-12">
          {list.length > 0 ? list : emptyView}
        </div>
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
