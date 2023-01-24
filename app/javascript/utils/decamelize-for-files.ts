// From https://github.com/domchristie/humps/issues/51#issuecomment-425113505
/* eslint-disable max-statements */
import { decamelize } from 'humps';

interface objectToDecamelize {
  [key: string]: unknown;
}

// eslint-disable-next-line complexity
function decamelizeThatDontBreaksFile(object: objectToDecamelize): unknown {
  if (object && !(object instanceof File)) {
    if (object instanceof Array) {
      return object.map(item => decamelizeThatDontBreaksFile(item));
    }
    if (object instanceof FormData) {
      const formData = new FormData();
      for (const [key, value] of object.entries()) {
        formData.append(decamelize(key), value);
      }

      return formData;
    }
    if (typeof object === 'object') {
      return Object.keys(object).reduce((acc, next) => ({
        ...acc,
        [decamelize(next)]: decamelizeThatDontBreaksFile(object[next] as objectToDecamelize),
      }), {});
    }
  }

  return object;
}

export default decamelizeThatDontBreaksFile;
