# UIDevTest Requirements Document
Author: Le Zhang ([leisms](http://github.com/leisms))  
Description: Requirements specifications for the UIDevTest project to help keep everything organized in an Agile way.

## Software Requirements
**User Story** - "As a \<role>, I want … (so that …)"  
**Functional Specifications** - To the \<role>, the software should "…"  
**Technical Specifications** - Behind the scenes, the software should "…"  

| ID | User Story | Functional Specifications | Technical Specifications |
|----|------------|---------------------------|--------------------------|
| R1 | As a user, I want to be able to view a list of news headlines so that I can quickly browse several articles. | 1. Load article data and populate a story list view when the user accesses the URL uidevtest/src/html/index.html. <br> 2. In each list item, display the article's:<br> - Headline Text <br> - Picture <br> - Categories <br> - Posted Date <br> - Updated Date | 1. Only use article data loaded from uidevtest/src/js/uidevtest-data.js |
| R2 | As a user, I want to be able to click on the title of a news headline so that I can view the full article. | 1. Navigate the user to the full story view of an article when the headline link is clicked, or when the article's story URL is accessed. | 1. Handle routing with a single html page. |
| R3 | As a user, I want to be able to view the full article for a news story. | 1. Display the article's: <br> - Headline Text <br> - Picture <br> - Picture Caption <br> - Picture Credit <br> - Article Text <br> - Author <br> 2. Display an action bar with comment, share, favorite and vote buttons. <br> 3. Display a navigation bar. | |
| R4 | As a user, I want the full view of the news articles to be optimized to my screen width so that it's easier to read. | 1. Change the design of the page to multi-column when the page width is greater than 480px and to single-column when the page-width is less.

## Design Requirements

### Story list view (all viewport sizes)

- Reference uidevtest/mockup-list.jpg
- Headline link text is 16px bold, #036dbe
- Category / categories text is 14px, #444444
- “Published” / “Updated” information is 14px, #444444
- Images have a dropshadow and a border applied

### Story view layouts (all viewport sizes)

- The social links (“Comment”, “Share”, “Favorite”, and “Vote”) have full-color sprite icons (uidevtest/src/images/uidevtest-sprite.png)
- All typefaces are Arial
- Breadcrumb is 11px bold, #036dbe
- Breadcrumb border is #cdcdcd
- Headline is 24px, #444444
- “Published” / “Updated” information is 11px, #444444
- Social links are 11px bold, #036dbe
- The story text is 14px with 18px line heights, #444444
- Links are #036dbe
- The photo caption is 14px with 14px line heights, #444444

### Three-column story layout (greater than 480px viewport)

- Reference uidevtest/mockup-wide.jpg
- Social links should display on the page as grayscale icons. Upon mouse-over (hover), they should display as full-color icons. Upon mouse-out, they should return to grayscale state.
- The layout is 260px columns with 15px gutters
- Photo credit is #000000 over a white background
- Photo credit background is at 60% opacity

### Single-column story layout (480px or less viewport)

- Reference uidevtest/mockup.jpg
- Social links should display as full-color icons. There is no visual change for hover or mouse-over.
- Photo credit is #898989