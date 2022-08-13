using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;

namespace THANHTOANTROIGIO.Helpers
{
    public class TokenHelper
    {
        public static string GenerateToken(int size = 32)
        {
            var randomNumber = new byte[size];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(randomNumber);
                return Convert.ToBase64String(randomNumber);
            }
        }

        public static string GenerateRandomPassword(int length = 8)
        {
            Random rand = new Random();
            string[] categories = {
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        "abcdefghijklmnopqrstuvwxyz",
        "~!@#$%^&*()_+/-.[]?{}:",
        "0123456789" };

            List<char> chars = new List<char>(length);

            // add one char from each category
            foreach (string cat in categories)
            {
                chars.Add(cat[rand.Next(cat.Length)]);
            }

            // add random chars from any category until we hit the length
            string all = string.Concat(categories);
            while (chars.Count < length)
            {
                chars.Add(all[rand.Next(all.Length)]);
            }

            // shuffle and return our password
            var shuffled = chars.OrderBy(c => rand.NextDouble()).ToArray();
            return new string(shuffled);
        }
    }
}