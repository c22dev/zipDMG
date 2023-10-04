const express = require('express');
const bodyParser = require('body-parser');
const axios = require('axios');
const app = express();
const port = 3000;
const { Octokit } = require("@octokit/core");
const octokit = new Octokit({
  auth: process.env['gittoken']
})

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Serve the HTML form
app.get('/', (req, res) => {
  res.send(`
    <html>
      <body>
        <form method="POST" action="/submit">
          <label for="dmgUrl">Enter DMG URL:</label>
          <input type="text" name="dmgUrl" id="dmgUrl">
          <button type="submit">Submit</button>
        </form>
        <p>Take first workflow in opened page</p>
      </body>
    </html>
  `);
});

// Handle form submission
app.post('/submit', async (req, res) => {
  const dmgUrl = req.body.dmgUrl;

  // GitHub raw content URL
  const rawFileUrl = 'https://raw.githubusercontent.com/c22dev/zipDMG/main/mount.sh';

  try {
    // Get the current content of the file
    const response = await axios.get(rawFileUrl);
    let content = response.data;

    // Update the content of the 'dmg_url' variable in mount.sh
    content = content.replace(/dmg_url\s*=\s*".*"/, `dmg_url="${dmgUrl}"`);
    contentb64 = Buffer.from(content).toString('base64');
    const contentBuffer = Buffer.from(contentb64, 'base64');

// Convert the Buffer back to a string (assuming it's a text content)
const contentde = contentBuffer.toString('utf-8');
    
    // Create a new commit with the updated content
    const commitMessage = 'Update dmg_url';
    const commitData = {
      message: commitMessage,
      content: contentde,
    };

    // Replace with your GitHub repository details
    const owner = 'c22dev'; // Your GitHub username
    const repo = 'zipDMG'; // Your GitHub repository name
    const filePath = 'mount.sh';
    const shaResponse = await axios.get(`https://api.github.com/repos/${owner}/${repo}/contents/${filePath}`);
  const sha = shaResponse.data.sha;
  // Update the file on GitHub
    await octokit.request('PUT /repos/c22dev/zipDMG/contents/mount.sh', {
  owner: 'c22dev',
  repo: 'zipDMG',
  path: 'mount.sh',
  sha: sha,
  message: 'web commit ',
  committer: {
    name: 'autowebsite',
    email: 'cclerc@cclerc.live'
  },
  content:  Buffer.from(content).toString('base64'),
  headers: {
    'X-GitHub-Api-Version': '2022-11-28'
  }
})


    // Redirect the user to the GitHub Actions page for the commit

async function getLatestCommitId() {
  try {
    const response = await axios.get(`https://api.github.com/repos/${owner}/${repo}/commits`, {
      headers: {
        Authorization: process.env['gittoken'], // Replace with your GitHub API token
      },
    });

    if (response.data.length > 0) {
      const latestCommitId = response.data[0].sha;
      return latestCommitId;
    } else {
      console.error('No commits found in the repository.');
      return null;
    }
  } catch (error) {
    console.error('Error fetching commits:', error.message);
    return null;
  }
}

// Call the function to get the latest commit ID and store it in a variable.

  const latestCommitId = await getLatestCommitId()

    
setTimeout(() => {
    res.redirect(`https://github.com/c22dev/zipDMG/actions/workflows/blank.yml`);
    }, 3000);
  } catch (error) {
    console.error(error);
    res.status(1000).send('An error occurred while updating the file on GitHub.');
  }
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
