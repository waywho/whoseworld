// patch to use v4 without node/yarn
// https://github.com/activeadmin/activeadmin/discussions/8223

import { execSync } from 'child_process';
import activeAdminPlugin from '@activeadmin/activeadmin/plugin';

const activeAdminPath = execSync('bundle show activeadmin', { encoding: 'utf-8' }).trim();

export default {
  content: [
    `${activeAdminPath}/vendor/javascript/flowbite.js`,
    `${activeAdminPath}/plugin.js`,
    `${activeAdminPath}/app/views/**/*.{arb,erb,html,rb,haml}`,
    './app/admin/**/*.{arb,erb,html,rb,haml}',
    './app/views/active_admin/**/*.{arb,erb,html,rb,haml}',
    './app/views/admin/**/*.{arb,erb,html,rb,haml}',
    './app/views/layouts/active_admin*.{erb,html,haml}',
    './app/javascript/**/*.js'
  ],
  darkMode: "selector",
  plugins: [
    require(`${activeAdminPath}/plugin.js`)
  ]
}
