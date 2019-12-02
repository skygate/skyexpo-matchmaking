import { createBrowserHistory as createHistory } from 'history';

export const history = createHistory();

export const handleRedirect = route => {
    history.push(`${route}`);
};
