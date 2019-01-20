<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="false" Inherits="BlogEngine.Core.Web.Controls.PostViewBase" %>
<%@ Import Namespace="BlogEngine.Core" %>
<%
    var singlePost = Location == ServingLocation.SinglePost;

    var postClass = "";

    var postAdminLinks = "";
    if (AdminLinks.Length > 0)
    {
        postAdminLinks = "<div class=\"post-adminlinks\">" + AdminLinks + "</div>";
    }
    var postUrl = Post.RelativeOrAbsoluteLink;
    var postTitle = Server.HtmlEncode(Post.Title);
    var postDate = Post.DateCreated.ToString("MMM dd, yyyy");
    var authorUrl = Utils.AbsoluteWebRoot + "author/" + Utils.RemoveIllegalCharacters(Post.Author + BlogConfig.FileExtension);
    var authorName = Post.AuthorProfile != null ? Utils.RemoveIllegalCharacters(Post.AuthorProfile.DisplayName) : Utils.RemoveIllegalCharacters(Post.Author);
    var authorAvatar = "/image.axd?picture=/avatars/" + Post.AuthorProfile.PhotoUrl;
    var authorAvatarStatus = "";
    if (Post.AuthorProfile.PhotoUrl.Length > 0)
    {
        authorAvatarStatus = "author-avatar-active";
    }

    var postCategory = CategoryLinks(", ");
    var postTags = "<div class=\"post-tags\">" + TagLinks(", ") + "</div>";

    var postFirstImage = Post.FirstImgSrc;
    var postImageLink = "<a class=\"post-cover\" href=\"" + postUrl + "\"><img src=\"" + Post.FirstImgSrc + "\" alt=\"" + postTitle + "\"></a>";

    if (postFirstImage.Length < 1)
    {
        postClass += " no-thumbnail";
    }
    var blogLogo = "[CUSTOMFIELD|THEME|clean|Publisher Logo|http://exampleblog.com/logo.png/]";
    var SharePost = "[CUSTOMFIELD|THEME|clean|Share (show or hide)|show/]";
%>


<% if (!singlePost)
    { %>
<article class="post-home" id="post<%=Index %>">
    <div class="post-home-inner d-flex flex-column">
        <% if (postFirstImage.Length > 1)
            { %><%=postImageLink %> <%} %>
        <header class="post-header">
            <% if (postCategory.Length > 0)
                {%><div class="post-category"><%=postCategory %></div>
            <% } %>
            <h2 class="post-title"><a class="post-link" href="<%=postUrl %>"><%=postTitle %></a></h2>
        </header>
        <div class="post-meta <%=authorAvatarStatus %>">
            <span class="post-author">
                <a href="<%=authorUrl %>">
                    <% if (Post.AuthorProfile.PhotoUrl.Length > 0)
                        { %>
                    <img class="post-author-avatar" src="<%=Utils.AbsoluteWebRoot%><%=authorAvatar %>" alt="<%=authorName %>" />
                    <%} %>
                    <%=authorName %></a>
            </span>
            <span class="post-date"><%=postDate %></span>
        </div>
    </div>
</article>
<%} %>


<% if (singlePost)
    {%>
<article class="post-single <%=postClass %>" id="post<%=Index %>">
    <header class="post-header">
        <h1 class="post-title"><%=postTitle %></h1>
        <div class="post-meta">
            <span class="post-author">by <a href="<%=authorUrl %>"><%=authorName %></a></span>
            <span class="post-date">on <%=postDate %></span>
            <% if (postCategory.Length > 0)
                {%><span class="post-category">in <%=postCategory %></span><% } %>
        </div>
    </header>
    <section class="post-body content-stlye">
        <asp:PlaceHolder ID="BodyContent" runat="server" />
        <%=postTags %>
    </section>
    <footer class="post-footer">
        <div class="row post-share <%=SharePost %>">
            <div class="col-4 mb-1 mb-md-0 col-md-2"><a class="item-fb" href="https://www.addtoany.com/add_to/facebook?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-facebook"></i><span>Facebook</span></a></div>
            <div class="col-4 mb-1 mb-md-0 col-md-2"><a class="item-tw" href="https://www.addtoany.com/add_to/twitter?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-twitter"></i><span>Twitter</span></a></div>
            <div class="col-4 mb-1 mb-md-0 col-md-2"><a class="item-gp" href="https://www.addtoany.com/add_to/google_plus?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-google-plus"></i><span>Google +</span></a></div>
            <div class="col-4 mb-1 mb-md-0 col-md-2"><a class="item-ln" href="https://www.addtoany.com/add_to/linkedin?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-linkedin"></i><span>LinkedIn</span></a></div>
            <div class="col-4 mb-1 mb-md-0 col-md-2"><a class="item-pi" href="https://www.addtoany.com/add_to/pinterest?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-pinterest"></i><span>Pinterest</span></a></div>
            <div class="col-4 mb-1 mb-md-0 col-md-2"><a class="item-em" href="https://www.addtoany.com/add_to/email?linkurl=<%=Post.AbsoluteLink %>&amp;linkname=<%=postTitle %>" target="_blank"><i class="fa fa-envelope"></i><span>Email</span></a></div>
        </div>
        <%=postAdminLinks %>
    </footer>
</article>
<script type="application/ld+json">
    {
      "@context": "http://schema.org",
      "@type": "NewsArticle",
      "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": "<%=Post.AbsoluteLink %>"
      },
      "headline": "<%=postTitle %>",
      <% if (postFirstImage.Length > 1)
    {%>"image": "<%=Utils.AbsoluteWebRoot + postFirstImage.TrimStart(' ', '/') %>",<%} %>
      "datePublished": "<%=Post.DateCreated.ToString("yyyy-MM-dd") %>",
      "dateModified": "<%=Post.DateModified.ToString("yyyy-MM-dd") %>",
      "author": {
        "@type": "Person",
        "name": "<%=authorName%>"
      },
       "publisher": {
        "@type": "Organization",
        "name": "<%=BlogSettings.Instance.Name %>",
        "logo": {
          "@type": "ImageObject",
          "url": "<%= blogLogo %>"
        }
      },
      "description": "<%=Utils.RemoveHtmlWhitespace(Post.Description)%>"
    }
</script>

<%} %>