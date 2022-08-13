using System.Security.Claims;
using System.Text;
using System.Text.Json;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Models.Cache;

namespace THANHTOANTROIGIO.Services
{
    public class AuthService
    {
        private readonly IDistributedCache _distributedCache;
        private readonly DistributedCacheEntryOptions cacheOpts = new DistributedCacheEntryOptions { AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(30) };
        private readonly ThanhToanTroiGioEntities _context;
        protected readonly ILogger _logger;
        public AuthService(IDistributedCache distributedCache,ThanhToanTroiGioEntities context, ILogger<AuthService> logger)
        {
            this._distributedCache = distributedCache;
            this._context = context;
            _logger = logger;
        }

        public string SaveAuthUser(string authSecret,GiangVien user, int id)
        {
            this.SetAuthUserCache(user,id);
            var accessTokenExpiration = DateTime.Now.AddMinutes(60);
            var accessToken = GenerateAccessToken(authSecret, id, accessTokenExpiration);
            return accessToken;
            //var refreshToken = TokenHelper.GenerateToken();
        }


        public void RemoveAuthUser(int userId, bool removeRefreshToken = false)
        {
            string authUserKey = $"AuthUser_Key:{userId}";
            var userJson = this._distributedCache.GetString(authUserKey);
            if (!string.IsNullOrWhiteSpace(userJson))
                this._distributedCache.Remove(authUserKey);
            // if (removeRefreshToken)
            //     UpdateRefreshTokenOfDeletedUser(userId);
        }

        public AuthUserCache GetCurrentAuthUser(string authToken)
        {
            AuthUserCache user = null;
            try
            {
                var validator = new JwtSecurityTokenHandler();
                var jwtToken = validator.ReadJwtToken(authToken);
                var userClaim = jwtToken.Claims.FirstOrDefault(e => e.Type == "ClaimUserCode");
                if (userClaim != null)
                {
                    string hashCode = userClaim.Value;
                    var hashIds = new HashidsNet.Hashids(salt: "NetSampleC@re!");
                    var data = hashIds.DecodeLong(hashCode);
                    int userId = (int)data[1];
                    user = this.GetAuthUserCache(userId);
                }
            }
            catch (Exception ex)
            {
                this._logger.LogError(message: $"Cannot parse UserId from token {authToken}" + authToken, exception: ex);
            }

            return user;
        }

        #region Private Methods

        private void SetAuthUserCache(GiangVien dbUser, int id)
        {
            string authUserKey = $"AuthUser_Key:{id}";
            this._distributedCache.Remove(authUserKey);
            AuthUserCache user = new AuthUserCache(dbUser, id);
            this._distributedCache.SetString(authUserKey, JsonSerializer.Serialize<AuthUserCache>(user), cacheOpts);
        }

        private AuthUserCache GetAuthUserCache(int userId)
        {
            AuthUserCache user = null;
            string authUserKey = $"AuthUser_Key:{userId}";
            var userJson = this._distributedCache.GetString(authUserKey);
            if (!string.IsNullOrWhiteSpace(userJson))
                user = JsonSerializer.Deserialize<AuthUserCache>(userJson);
            return user;
        }

        private string GenerateAccessToken(string authSecret,int id, DateTime accessTokenExpiration)
        {
            DateTimeOffset dto = new DateTimeOffset(DateTime.UtcNow, TimeSpan.Zero);
            var unixDate = dto.ToUnixTimeMilliseconds();
            var hashIds = new HashidsNet.Hashids(salt: "NetSampleC@re!");
            var userCode = hashIds.EncodeLong(unixDate, id);

            var claims = new[] {
                new Claim("ClaimUserCode", userCode),
                new Claim(ClaimTypes.Role, "Admin")
            };
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(authSecret));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
            var token = new JwtSecurityToken(claims: claims,
                                              expires: accessTokenExpiration,
                                              signingCredentials: creds);
            return new JwtSecurityTokenHandler().WriteToken(token);
        }
        #endregion
    }
}