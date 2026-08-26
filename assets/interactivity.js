document.addEventListener('DOMContentLoaded', () => {
  // Inject style.css link if not present
  if (!document.querySelector('link[href="style.css"]')) {
    const link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = 'style.css';
    document.head.appendChild(link);
  }

  // Create Sidebar Element
  const sidebar = document.createElement('aside');
  sidebar.id = 'app-sidebar';

  // Sidebar Header
  const header = document.createElement('div');
  header.className = 'sidebar-header';
  header.innerHTML = `
    <div class="sidebar-title">Three Treasures Sangha</div>
    <div class="sidebar-subtitle">Sutra Book • Interactive Edition</div>
  `;
  sidebar.appendChild(header);

  // Controls Card (Ino notes OFF by default)
  const controlsCard = document.createElement('div');
  controlsCard.className = 'controls-card';
  controlsCard.innerHTML = `
    <div class="controls-card-title">Display Controls</div>
    <div class="toggle-group">
      <label class="toggle-item">
        <span>☯ Chinese Characters</span>
        <input type="checkbox" id="toggle-cjk" class="toggle-switch" checked>
      </label>
      <label class="toggle-item">
        <span>🥁 Ino Notes & Percussion</span>
        <input type="checkbox" id="toggle-ino" class="toggle-switch">
      </label>
      <label class="toggle-item">
        <span>🔗 Glossary Hyperlinks</span>
        <input type="checkbox" id="toggle-links" class="toggle-switch" checked>
      </label>
    </div>
  `;
  sidebar.appendChild(controlsCard);

  // Sidebar Table of Contents Container
  const tocContainer = document.createElement('div');
  tocContainer.id = 'sidebar-toc';
  const tocTitle = document.createElement('div');
  tocTitle.className = 'toc-section-title';
  tocTitle.textContent = 'Table of Contents';
  tocContainer.appendChild(tocTitle);

  // Clone document TOC into sidebar and normalize every entry into a single clean link
  const existingToc = document.querySelector('nav[role="doc-toc"]');
  if (existingToc) {
    const clonedToc = existingToc.cloneNode(true);
    clonedToc.querySelectorAll('li').forEach(li => {
      const locLink = li.querySelector('a[href^="#loc-"]');
      if (locLink) {
        const targetHref = locLink.getAttribute('href');
        const pOrDiv = li.querySelector('p, div');
        if (pOrDiv) {
          const entryText = pOrDiv.textContent.trim();
          pOrDiv.innerHTML = `<a href="${targetHref}">${entryText}</a>`;
        }
      }
    });
    tocContainer.appendChild(clonedToc);
  }
  sidebar.appendChild(tocContainer);

  // Wrap body content in main container
  const mainContent = document.createElement('main');
  mainContent.id = 'main-content';

  // Inject Document Header at the top of main content
  const docHeader = document.createElement('header');
  docHeader.className = 'document-header';
  docHeader.innerHTML = `
    <h1 class="document-title">Three Treasures Sangha Sutra Book</h1>
    <div class="document-subtitle">Zenkai and Sesshin Recitations</div>
  `;
  mainContent.appendChild(docHeader);

  while (document.body.firstChild) {
    mainContent.appendChild(document.body.firstChild);
  }

  document.body.appendChild(sidebar);
  document.body.appendChild(mainContent);

  // Sanitize main content headings: strip nested glossary links from all headings & titles
  document.querySelectorAll('h1, h2, h3, .sutra-heading, .document-title, .document-section-title').forEach(heading => {
    heading.querySelectorAll('a[href^="#gloss-"], .glossary-link').forEach(glossEl => {
      glossEl.replaceWith(document.createTextNode(glossEl.textContent));
    });
  });

  // Set default body state (Ino notes OFF by default)
  document.body.classList.add('hide-ino');

  // Toggle Event Listeners
  const cjkToggle = document.getElementById('toggle-cjk');
  const inoToggle = document.getElementById('toggle-ino');
  const linksToggle = document.getElementById('toggle-links');

  if (cjkToggle) {
    cjkToggle.addEventListener('change', (e) => {
      document.body.classList.toggle('hide-cjk', !e.target.checked);
    });
  }

  if (inoToggle) {
    inoToggle.addEventListener('change', (e) => {
      document.body.classList.toggle('hide-ino', !e.target.checked);
    });
  }

  if (linksToggle) {
    linksToggle.addEventListener('change', (e) => {
      document.body.classList.toggle('hide-links', !e.target.checked);
    });
  }

  // Smooth scroll for TOC links
  document.querySelectorAll('#sidebar-toc a').forEach(anchor => {
    anchor.addEventListener('click', (e) => {
      const targetId = anchor.getAttribute('href');
      if (targetId && targetId.startsWith('#')) {
        const targetEl = document.querySelector(targetId);
        if (targetEl) {
          e.preventDefault();
          targetEl.scrollIntoView({ behavior: 'smooth' });
        }
      }
    });
  });
});
