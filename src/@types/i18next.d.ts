import 'i18next';
import { defaultNS, resources } from '~/i18n';

declare module 'i18next' {
  interface CustomTypeOptions {
    returnNull: false;
    defaultNS: typeof defaultNS;
    resources: (typeof resources)['vi'];
  }
}
