import React from 'react';
import PropComponent from './prop';
import PaginationComponent from '.././shared/pagination';
import VoteComponent from './vote';

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

  renderProps(list) {
    if (list.length > 0) {
      return (
        <ul className="list-unstyled">
          <div className="col-xs-12">
            {list}
          </div>
        </ul>
      );
    }
    return (<div>no props here</div>);
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
          key={item.id}
          voteComponent={
            <VoteComponent
              upvotesCount={propData.upvotesCount}
              isUpvotePossible={propData.isUpvotePossible}
              onUpvote={item.upvote.bind(item)}
            />
          }
        />
      );
    });

    return (
      <div>
        {this.renderProps(list)}
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
