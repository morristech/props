import fetch from 'isomorphic-fetch';

export default class ParametricFetch {

  constructor(opts) {
    this.opts = opts || {};
    if (!this.opts.baseURI) {
      throw new Error('baseURI option is required');
    }
    this.cookies = { credentials: 'same-origin' };
  }

  propertySerializer(object, property) {
    return `${encodeURIComponent(property)}=${encodeURIComponent(object[property])}`;
  }

  serialize(object) {
    const serialized = [];
    for (const property in object) {
      if (object.hasOwnProperty(property)) {
        serialized.push(this.propertySerializer(object, property));
      }
    }
    return serialized.join('&');
  }

  parameterizeUrl(url, params) {
    if (params) {
      return [url, this.serialize(params)].join('?');
    }
    return url;
  }

  fetchMe(url, params = {}) {
    const parametricUrl = this.parameterizeUrl(this.opts.baseURI + url, params);
    return fetch(parametricUrl, this.cookies).then(req => req.json());
  }
}
